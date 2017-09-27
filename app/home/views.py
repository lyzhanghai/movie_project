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
