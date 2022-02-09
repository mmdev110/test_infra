FROM hashicorp/terraform:latest
WORKDIR /src/
ADD . /src/
#元イメージのENTRYPOINTを無効化
ENTRYPOINT []