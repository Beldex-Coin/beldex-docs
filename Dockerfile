FROM python:3 as docs-build
LABEL user = "codeman-crypto"
WORKDIR /app
COPY . ./
# installing dependencies
RUN pip install mkdocs
RUN pip install mkdocs-material
EXPOSE 8000
RUN mkdocs build --clean
# Stage 2 - the production environment
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
#COPY --from=docs-build /app/ /usr/share/nginx/html
COPY --from=docs-build /app/site /usr/share/nginx/html
RUN chmod 755 /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


