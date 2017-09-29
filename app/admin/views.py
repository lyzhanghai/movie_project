#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.admin import admin
from flask import render_template, redirect, url_for, flash, session, request
from app.admin.forms import LoginForm
from app.models import Admin
from functools import wraps


# 定义登录判断装饰器
def admin_login_req(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # 判断session是否存在，并做处理
        if "admin" not in session:
            return redirect(url_for("admin.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


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
@admin.route("/tag/add/")
@admin_login_req
def tag_add():
    return render_template("admin/tag_add.html")


# 定义标签列表视图
@admin.route("/tag/list/")
@admin_login_req
def tag_list():
    return render_template("admin/tag_list.html")


# 定义添加电影视图
@admin.route("/movie/add/")
@admin_login_req
def movie_add():
    return render_template("admin/movie_add.html")


# 定义电影列表视图
@admin.route("/movie/list/")
@admin_login_req
def movie_list():
    return render_template("admin/movie_list.html")


# 定义添加预告视图
@admin.route("/preview/add/")
@admin_login_req
def preview_add():
    return render_template("admin/preview_add.html")


# 定义预告列表视图
@admin.route("/preview/list/")
@admin_login_req
def preview_list():
    return render_template("admin/preview_list.html")


# 定义会员列表视图
@admin.route("/user/list/")
@admin_login_req
def user_list():
    return render_template("admin/user_list.html")


# 定义查看会员视图
@admin.route("/user/view/")
@admin_login_req
def user_view():
    return render_template("admin/user_view.html")


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
