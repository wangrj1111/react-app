#构建阶段
FROM node:20 AS build
#设置工作目录
WORKDIR /app
#复制package.json和package-lock.json
COPY package*.json ./
#安装依赖
RUN npm config set registry https://registry.npmirror.com
RUN npm install
#复制项目文件
COPY . .
#构建项目
RUN npm run build

#运行阶段
FROM nginx:stable-alpine
#复制构建后的文件到nginx的默认目录
COPY --from=build /app/dist /usr/share/nginx/html
#暴露端口
EXPOSE 80
#启动nginx
CMD ["nginx", "-g", "daemon off;"]
