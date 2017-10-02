#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app import db, app
from app.admin import admin
from flask import render_template, redirect, url_for, flash, session, request
from app.admin.forms import LoginForm, TagForm, MovieForm, PreviewForm
from app.models import Admin, Tag, Movie, Preview, User
from functools import wraps
from werkzeug.utils import secure_filename
import os, uuid, datetime

page_data = None  # 为共享分页数据


# 定义登录判断装饰器
def admin_login_req(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # 判断session是否存在，并做处理
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


# 修改文件名称
def change_filename(filename):
    fileinfo = os.path.splitext(filename)  # 对名字进行前后缀分离
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + "_" + uuid.uuid4().hex + fileinfo[-1]  # 生成新文件名
    return filename


# 调用蓝图（定义视图）
# 定义控制面板视图
@admin.route("/")
@admin_login_req
def index():
    return render_template("admin/index.html")


# 定义登录视图
@admin.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()  # 导入登录表单
    if form.validate_on_submit():  # 对提交的表单验证
        data = form.data
        admin = Admin.query.filter_by(name=data["account"]).first()
        if not admin.check_pwd(data["pwd"]):
            flash("密码错误！")
            return redirect(url_for("admin.login"))
        session["admin"] = data["account"]
        return redirect(request.args.get("next") or url_for("admin.index"))
    return render_template("admin/login.html", form=form)


# 定义登出视图
@admin.route("/logout/")
@admin_login_req
def logout():
    session.pop("admin")  # 移除用户session
    return redirect(url_for("admin.login"))


# 定义修改密码视图
@admin.route("/pwd/")
@admin_login_req
def pwd():
    return render_template("admin/pwd.html")


# 定义添加标签视图
@admin.route("/tag/add/", methods=["GET", "POST"])
@admin_login_req
def tag_add():
    form = TagForm()
    if form.validate_on_submit():
        data = form.data
        tag = Tag.query.filter_by(name=data["name"]).count()
        if tag == 1:
            flash("名称已经存在！", "err")
            return redirect(url_for("admin.tag_add"))
        tag = Tag(
            name=data["name"]
        )
        db.session.add(tag)
        db.session.commit()
        flash("添加标签成功！", "ok")
        return redirect(url_for("admin.tag_add"))
    return render_template("admin/tag_add.html", form=form)


# 定义编辑标签视图
@admin.route("/tag/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
def tag_edit(id=None):
    form = TagForm()
    tag = Tag.query.get_or_404(id)
    page = page_data.page if page_data is not None else 1
    if form.validate_on_submit():
        data = form.data
        tag_count = Tag.query.filter_by(name=data["name"]).count()
        if tag_count == 1:
            flash("名称已经存在！", "err")
            return redirect(url_for("admin.tag_edit", id=id))
        tag.name = data["name"]
        db.session.add(tag)
        db.session.commit()
        flash("修改标签成功！", "ok")
        return redirect(url_for("admin.tag_list", page=page))
    return render_template("admin/tag_edit.html", form=form, tag=tag, page=page)


# 定义标签列表视图
@admin.route("/tag/list/<int:page>/", methods=["GET"])
@admin_login_req
def tag_list(page=None):
    global page_data
    if page is None:
        page = 1
    page_data = Tag.query.order_by(
        Tag.addtime.desc()
    ).paginate(page=page, per_page=app.config['PAGE_SET'])
    return render_template("admin/tag_list.html", page_data=page_data)


# 定义标签删除视图
@admin.route("/tag/del/<int:id>/", methods=["GET"])
@admin_login_req
def tag_del(id=None):
    if page_data.pages == 1 or page_data is None:
        page = 1
    else:
        page = page_data.page if page_data.page < page_data.pages or page_data.total % page_data.per_page != 1 else page_data.pages - 1
    tag = Tag.query.filter_by(id=id).first_or_404()
    db.session.delete(tag)
    db.session.commit()
    flash("删除标签成功！", "ok")
    return redirect(url_for("admin.tag_list", page=page))


# 定义添加电影视图
@admin.route("/movie/add/", methods=["GET", "POST"])
@admin_login_req
def movie_add():
    form = MovieForm()
    if form.validate_on_submit():
        data = form.data
        if Movie.query.filter_by(title=data["title"]).count() == 1:
            flash("影片已经存在！", "err")
            return redirect(url_for("admin.movie_add"))
        file_url = secure_filename(form.url.data.filename)  # 获取并转化为安全的电影文件名
        file_logo = secure_filename(form.logo.data.filename)
        if not os.path.exists(app.config['UP_DIR']):  # 存放目录不存在则创建
            os.makedirs(app.config['UP_DIR'])
            os.chmod(app.config['UP_DIR'], "rw")
        url = change_filename(file_url)  # 调用函数生成新的文件名
        logo = change_filename(file_logo)
        form.url.data.save(app.config['UP_DIR'] + url)  # 保存上传的数据
        form.logo.data.save(app.config['UP_DIR'] + logo)
        movie = Movie(
            title=data["title"],
            url=url,
            info=data["info"],
            logo=logo,
            star=int(data["star"]),
            playnum=0,
            commentnum=0,
            tag_id=int(data["tag_id"]),
            area=data["area"],
            release_time=data["release_time"],
            length=data["length"]
        )
        db.session.add(movie)
        db.session.commit()
        flash("添加电影成功！", "ok")
        return redirect(url_for("admin.movie_add"))
    return render_template("admin/movie_add.html", form=form)


# 定义编辑标签视图
@admin.route("/movie/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
def movie_edit(id=None):
    form = MovieForm()
    form.url.validators = []  # 因为可以不做更改，所以不需要校验
    form.logo.validators = []
    movie = Movie.query.get_or_404(id)
    page = page_data.page if page_data is not None else 1
    if request.method == "GET":
        form.info.data = movie.info
        form.star.data = movie.star
        form.tag_id.data = movie.tag_id
    if form.validate_on_submit():
        data = form.data
        movie_count = Movie.query.filter_by(title=data["title"]).count()
        if movie.title != data['title'] and movie_count == 1:
            flash("片名已经存在！", "err")
            return redirect(url_for("admin.movie_edit", id=id))

        if not os.path.exists(app.config['UP_DIR']):  # 存放目录不存在则创建
            os.makedirs(app.config['UP_DIR'])
            os.chmod(app.config['UP_DIR'], "rw")

        if form.url.data.filename != '':
            old_url = movie.url
            file_url = secure_filename(form.url.data.filename)  # 获取并转化为安全的电影文件名
            movie.url = change_filename(file_url)  # 调用函数生成新的文件名
            form.url.data.save(app.config['UP_DIR'] + movie.url)  # 保存上传的数据
            if os.path.exists(app.config['UP_DIR'] + old_url):  # 删除旧文件
                os.remove(app.config['UP_DIR'] + old_url)

        if form.logo.data.filename != '':
            old_logo = movie.logo
            file_logo = secure_filename(form.logo.data.filename)
            movie.logo = change_filename(file_logo)
            form.logo.data.save(app.config['UP_DIR'] + movie.logo)
            if os.path.exists(app.config['UP_DIR'] + old_logo):
                os.remove(app.config['UP_DIR'] + old_logo)

        movie.title = data["title"]
        movie.info = data["info"]
        movie.star = int(data["star"])
        movie.tag_id = int(data["tag_id"])
        movie.area = data["area"]
        movie.release_time = data["release_time"]
        movie.length = data["length"]
        db.session.add(movie)
        db.session.commit()
        flash("修改电影成功！", "ok")
        return redirect(url_for("admin.movie_list", page=page))
    return render_template("admin/movie_edit.html", form=form, movie=movie, page=page)


# 定义电影列表视图
@admin.route("/movie/list/<int:page>/", methods=["GET"])
@admin_login_req
def movie_list(page=None):
    global page_data
    if page is None:
        page = 1
    page_data = Movie.query.join(Tag).filter(
        Movie.tag_id == Tag.id
    ).order_by(
        Movie.addtime.desc()
    ).paginate(page=page, per_page=app.config['PAGE_SET'])
    return render_template("admin/movie_list.html", page_data=page_data)


# 定义电影删除视图
@admin.route("/movie/del/<int:id>/", methods=["GET"])
@admin_login_req
def movie_del(id=None):
    if page_data.pages == 1 or page_data is None:
        page = 1
    else:
        page = page_data.page if page_data.page < page_data.pages or page_data.total % page_data.per_page != 1 else page_data.pages - 1
    movie = Movie.query.filter_by(id=id).first_or_404()
    db.session.delete(movie)
    db.session.commit()
    if os.path.exists(app.config['UP_DIR'] + movie.url):  # 删除文件
        os.remove(app.config['UP_DIR'] + movie.url)
    if os.path.exists(app.config['UP_DIR'] + movie.logo):
        os.remove(app.config['UP_DIR'] + movie.logo)
    flash("删除电影成功！", "ok")
    return redirect(url_for("admin.movie_list", page=page))


# 定义添加预告视图
@admin.route("/preview/add/", methods=["GET", "POST"])
@admin_login_req
def preview_add():
    form = PreviewForm()
    if form.validate_on_submit():
        data = form.data
        preview = Preview.query.filter_by(title=data["title"]).count()
        if preview == 1:
            flash("预告标题已经存在！", "err")
            return redirect(url_for("admin.preview_add"))
        file_logo = secure_filename(form.logo.data.filename)
        if not os.path.exists(app.config['UP_DIR']):
            os.makedirs(app.config['UP_DIR'])
            os.chmod(app.config['UP_DIR'], "rw")
        logo = change_filename(file_logo)
        form.logo.data.save(app.config['UP_DIR'] + logo)
        preview = Preview(
            title=data["title"],
            logo=logo
        )
        db.session.add(preview)
        db.session.commit()
        flash("添加预告成功！", "ok")
        return redirect(url_for("admin.preview_add"))
    return render_template("admin/preview_add.html", form=form)


# 定义编辑预告视图
@admin.route("/preview/edit/<int:id>/", methods=["GET", "POST"])
@admin_login_req
def preview_edit(id=None):
    form = PreviewForm()
    form.logo.validators = []
    preview = Preview.query.get_or_404(id)
    page = page_data.page if page_data is not None else 1
    if form.validate_on_submit():
        data = form.data
        preview_count = Preview.query.filter_by(title=data["title"]).count()
        if preview.title != data['title'] and preview_count == 1:
            flash("预告标题已经存在！", "err")
            return redirect(url_for("admin.preview_edit", id=id))

        if not os.path.exists(app.config['UP_DIR']):
            os.makedirs(app.config['UP_DIR'])
            os.chmod(app.config['UP_DIR'], "rw")

        if form.logo.data.filename != '':
            old_logo = preview.logo
            file_logo = secure_filename(form.logo.data.filename)
            preview.logo = change_filename(file_logo)
            form.logo.data.save(app.config['UP_DIR'] + preview.logo)
            if os.path.exists(app.config['UP_DIR'] + old_logo):
                os.remove(app.config['UP_DIR'] + old_logo)

        preview.title = data["title"]
        db.session.add(preview)
        db.session.commit()
        flash("修改预告成功！", "ok")
        return redirect(url_for("admin.preview_list", page=page))
    return render_template("admin/preview_edit.html", form=form, preview=preview, page=page)


# 定义预告列表视图
@admin.route("/preview/list/<int:page>/", methods=["GET", "POST"])
@admin_login_req
def preview_list(page=None):
    global page_data
    if page is None:
        page = 1
    page_data = Preview.query.order_by(
        Preview.addtime.desc()
    ).paginate(page=page, per_page=app.config['PAGE_SET'])
    return render_template("admin/preview_list.html", page_data=page_data)


# 定义预告删除视图
@admin.route("/preview/del/<int:id>/", methods=["GET"])
@admin_login_req
def preview_del(id=None):
    if page_data.pages == 1 or page_data is None:
        page = 1
    else:
        page = page_data.page if page_data.page < page_data.pages or page_data.total % page_data.per_page != 1 else page_data.pages - 1
    preview = Preview.query.filter_by(id=id).first_or_404()
    db.session.delete(preview)
    db.session.commit()
    if os.path.exists(app.config['UP_DIR'] + preview.logo):
        os.remove(app.config['UP_DIR'] + preview.logo)
    flash("删除预告成功！", "ok")
    return redirect(url_for("admin.preview_list", page=page))


# 定义会员列表视图
@admin.route("/user/list/<int:page>/", methods=["GET"])
@admin_login_req
def user_list(page=None):
    global page_data
    if page is None:
        page = 1
    page_data = User.query.order_by(
        User.addtime.desc()
    ).paginate(page=page, per_page=app.config['PAGE_SET'])
    return render_template("admin/user_list.html", page_data=page_data)


# 定义查看会员视图
@admin.route("/user/view/<int:id>/", methods=["GET"])
@admin_login_req
def user_view(id=None):
    user = User.query.get_or_404(id)
    page = page_data.page if page_data is not None else 1
    return render_template("admin/user_view.html", user=user, page=page)


# 定义会员删除视图
@admin.route("/user/del/<int:id>/", methods=["GET"])
@admin_login_req
def user_del(id=None):
    if page_data.pages == 1 or page_data is None:
        page = 1
    else:
        page = page_data.page if page_data.page < page_data.pages or page_data.total % page_data.per_page != 1 else page_data.pages - 1
    user = User.query.filter_by(id=id).first_or_404()
    db.session.delete(user)
    db.session.commit()
    if os.path.exists(app.config['UP_DIR'] + "users" + os.sep + user.face):
        os.remove(app.config['UP_DIR'] + "users" + os.sep + user.face)
    flash("删除会员成功！", "ok")
    return redirect(url_for("admin.user_list", page=page))


# 定义评论列表视图
@admin.route("/comment/list/")
@admin_login_req
def comment_list():
    return render_template("admin/comment_list.html")


# 定义收藏列表视图
@admin.route("/moviecol/list/")
@admin_login_req
def moviecol_list():
    return render_template("admin/moviecol_list.html")


# 定义操作日志列表视图
@admin.route("/oplog/list/")
@admin_login_req
def oplog_list():
    return render_template("admin/oplog_list.html")


# 定义管理员登录日志列表视图
@admin.route("/adminloginlog/list/")
@admin_login_req
def adminloginlog_list():
    return render_template("admin/adminloginlog_list.html")


# 定义会员登录日志列表视图
@admin.route("/userloginlog/list/")
@admin_login_req
def userloginlog_list():
    return render_template("admin/userloginlog_list.html")


# 定义添加权限视图
@admin.route("/auth/add/")
@admin_login_req
def auth_add():
    return render_template("admin/auth_add.html")


# 定义权限列表视图
@admin.route("/auth/list/")
@admin_login_req
def auth_list():
    return render_template("admin/auth_list.html")


# 定义添加角色视图
@admin.route("/role/add/")
@admin_login_req
def role_add():
    return render_template("admin/role_add.html")


# 定义角色列表视图
@admin.route("/role/list/")
@admin_login_req
def role_list():
    return render_template("admin/role_list.html")


# 定义添加管理员视图
@admin.route("/admin/add/")
@admin_login_req
def admin_add():
    return render_template("admin/admin_add.html")


# 定义管理员列表视图
@admin.route("/admin/list/")
@admin_login_req
def admin_list():
    return render_template("admin/admin_list.html")
