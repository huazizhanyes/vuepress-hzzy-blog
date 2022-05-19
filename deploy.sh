#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
# set -e

# 生成静态文件
# npm run build

# 进入生成的文件夹
# cd docs/.vuepress/dist
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=blog.hzzy.xyz&token=XDBAanwPu0JphsAQ"
# deploy to github pages
# echo 'blog.hzzy.xyz' > CNAME
# git add .
# git commit -m 'commit'
# git config --global user.name "huazizhanyes"
# git config --global user.email "2585717148@qq.com"
# git config --global http.sslVerify 'false'

# git remote add origin https://github.com/huazizhanyes/hzzy.github.io.git
# git push -u origin main

# cd -
# rm -rf docs/.vuepress/dist
