#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:24.04
ARG APISIX_VERSION=3.15.0 

RUN arch=$(dpkg --print-architecture);     apt update;     apt-get -y install --no-install-recommends wget gnupg ca-certificates curl;    . /etc/os-release;     case "${arch}" in       amd64)         wget -O - https://repos.apiseven.com/pubkey.gpg | apt-key add -         && echo "deb https://repos.apiseven.com/packages/ubuntu $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/apisix.list         ;;       arm64)         wget -O - https://repos.apiseven.com/pubkey.gpg | apt-key add -         && echo "deb https://repos.apiseven.com/packages/arm64/ubuntu $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/apisix.list         ;;     esac;     apt update \
        && apt install -y apisix=${APISIX_VERSION}-0 \
        && apt-get purge -y --auto-remove \
        && rm /usr/local/openresty/bin/etcdctl \
        && openresty -V \
        && apisix version # buildkit
