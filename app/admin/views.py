#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.admin import admin
from flask import render_template, redirect, url_for


# 调用蓝图（定义视图）
@admin.route("/")
def index():
    return render_template("admin/index.html")


# 定义登录视图
@admin.route("/login/")
def login():
    return render_template("admin/login.html")


# 定义登出视图
@admin.route("/logout/")
def logout():
    return redirect(url_for("admin.login"))
