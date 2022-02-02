FROM hashicorp/terraform:latest
#RUN apk update && apk add git
WORKDIR /terraform/
#CMD ["air", "-c", ".air.toml"]
#CMD ["air"]