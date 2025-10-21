FROM rust:alpine as builder

RUN apk add --no-cache musl-dev
RUN cargo install mdbook

WORKDIR /app
COPY . .
RUN mdbook build

FROM nginx:alpine
COPY --from=builder /app/book /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]