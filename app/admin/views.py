#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.admin import admin
from flask import render_template, redirect, url_for


# 调用蓝图（定义视图）
# 定义控制面板视图
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


# 定义修改密码视图
@admin.route("/pwd/")
def pwd():
    return render_template("admin/pwd.html")

# 定义添加标签视图
@admin.route("/tag/add/")
def tag_add():
    return render_template("admin/tag_add.html")


# 定义标签列表视图
@admin.route("/tag/list")
def tag_list():
    return render_template("admin/tag_list.html")