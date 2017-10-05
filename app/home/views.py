#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app import db
from app.home import home
from app.home.forms import RegistForm
from app.models import User
from flask import render_template, redirect, url_for, flash
from werkzeug.security import generate_password_hash
import uuid


# 调用蓝图（定义视图）
# @home.route("/")
# def index():
#     return render_template("home/index.html")


# 定义登录视图
@home.route("/login/")
def login():
    return render_template("home/login.html")


# 定义登出视图
@home.route("/logout/")
def logout():
    return redirect(url_for("home.login"))


# 定义注册视图
@home.route("/regist/", methods=["GET", "POST"])
def regist():
    form = RegistForm()
    if form.validate_on_submit():
        data = form.data
        user = User(
            name=data["name"],
            pwd=generate_password_hash(data["pwd"]),
            email=data["email"],
            phone=data["phone"],
            uuid=uuid.uuid4().hex
        )
        db.session.add(user)
        db.session.commit()
        flash("注册成功，请登录！", "ok")
        return redirect(url_for("home.login"))
    return render_template("home/regist.html", form=form)


# 定义会员中心视图
@home.route("/user/")
def user():
    return render_template("home/user.html")


# 定义修改密码视图
@home.route("/pwd/")
def pwd():
    return render_template("home/pwd.html")


# 定义评论记录视图
@home.route("/comments/")
def comments():
    return render_template("home/comments.html")


# 定义登录日志视图
@home.route("/loginlog/")
def loginlog():
    return render_template("home/loginlog.html")


# 定义收藏电影视图
@home.route("/moviecol/")
def moviecol():
    return render_template("home/moviecol.html")


# 定义首页列表视图
@home.route("/")
def index():
    return render_template("home/index.html")


# 定义首页动画视图
@home.route("/animation/")
def animation():
    return render_template("home/animation.html")


# 定义电影搜索视图
@home.route("/search/")
def search():
    return render_template("home/search.html")


# 定义电影详情视图
@home.route("/play/")
def play():
    return render_template("home/play.html")
