#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : views.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34


from app.home import home


# 调用蓝图（定义视图）
@home.route("/")
def index():
    return "<h1 style='color:green'>This is home</h1>"
