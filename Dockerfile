# SPDX-FileCopyrightText: 2024 PNED G.I.E.
#
# SPDX-License-Identifier: Apache-2.0

FROM nginx:latest

# Dummy file to build a docker image with a simple index.html
ADD index.html /usr/share/nginx/html

EXPOSE 80
