#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @File    : forms.py
# @author  : Jaxon
# @software: PyCharm
# @datetime: 9/26 026 下午 07:34

from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, EqualTo, Email, Regexp, ValidationError
from app.models import User


class RegistForm(FlaskForm):
    """会员注册表单"""
    name = StringField(
        label="昵称",
        validators=[
            DataRequired("请输入昵称！")
        ],
        description="昵称",
        render_kw={  # 附加选项
            "class": "form-control input-lg",
            "placeholder": "请输入昵称！",
            "autofocus": ""
            # "required": "required"  # 添加强制属性，H5会在前端验证
        }
    )
    email = StringField(
        label="邮箱",
        validators=[
            DataRequired("请输入邮箱！"),
            Email("邮箱格式不正确！")
        ],
        description="邮箱",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入邮箱！"
        }
    )
    phone = StringField(
        label="手机",
        validators=[
            DataRequired("请输入手机号码！"),
            Regexp("^1[3|4|5|7|8][0-9]{9}$", message="手机号码格式不正确！")
        ],
        description="手机",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入手机号码！"
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("请输入密码！")
        ],
        description="密码",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入密码！"
        }
    )
    re_pwd = PasswordField(
        label="确认密码",
        validators=[
            DataRequired("请再次输入密码！"),
            EqualTo('pwd', message="两次密码输入不一致！")
        ],
        description="确认密码",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请再次输入密码！"
        }
    )
    submit = SubmitField(
        '注册',
        render_kw={
            "class": "btn btn-lg btn-success btn-block"
        }
    )

    # 昵称验证
    def validate_name(self, field):
        name = field.data
        if User.query.filter_by(name=name).count() == 1:
            raise ValidationError("昵称已经存在！")

    def validate_email(self, field):
        email = field.data
        if User.query.filter_by(email=email).count() == 1:
            raise ValidationError("邮箱已经存在！")

    def validate_phone(self, field):
        phone = field.data
        if User.query.filter_by(phone=phone).count() == 1:
            raise ValidationError("手机号码已经存在！")


class LoginForm(FlaskForm):
    """会员登录表单"""
    name = StringField(
        label="账号",
        validators=[
            DataRequired("请输入账号！")
        ],
        description="账号",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入账号！",
            "autofocus": ""
        }
    )
    pwd = PasswordField(
        label="密码",
        validators=[
            DataRequired("请输入密码！")
        ],
        description="密码",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入密码！"
        }
    )
    submit = SubmitField(
        '登录',
        render_kw={
            "class": "btn btn-lg btn-primary btn-block"
        }
    )

    # 账号验证
    def validate_name(self, field):
        name = field.data
        if User.query.filter_by(name=name).count() == 0:
            raise ValidationError("账号不存在！")
