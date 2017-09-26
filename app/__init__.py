#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : __init__.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:29


from flask import Flask

# 配置Flask
app = Flask(__name__)
app.debug = True

from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

# 注册蓝图
app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint, url_prefix="/admin")  # 添加url前缀
