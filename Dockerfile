FROM node:20-alpine as npm_install_and_build
WORKDIR /MyApp
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


FROM nginx:alpine AS deployment
COPY --from=npm_install_and_build /MyApp/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]