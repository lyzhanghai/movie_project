#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.home import home
from flask import render_template, redirect, url_for


# 调用蓝图（定义视图）
@home.route("/")
def index():
    return render_template("home/index.html")


# 定义登录视图
@home.route("/login/")
def login():
    return render_template("home/login.html")


# 定义登出视图
@home.route("/logout/")
def logout():
    return redirect(url_for("home.login"))


# 定义注册视图
@home.route("/regist/")
def regist():
    return render_template("home/regist.html")


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
