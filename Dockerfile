FROM hashicorp/terraform:latest
WORKDIR /terraform/
ADD . /terraform/
#元イメージのENTRYPOINTを無効化
ENTRYPOINT []