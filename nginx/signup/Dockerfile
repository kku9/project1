FROM nginx:1.20-alpine
  
ENV TZ=Asia/Seoul

COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html

EXPOSE 80
