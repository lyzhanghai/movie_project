#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.admin import admin


# 调用蓝图（定义视图）
@admin.route("/")
def index():
    return "<h1 style='color:blue'>This is admin</h1>"
