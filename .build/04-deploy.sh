#!/bin/bash

# Travis CI Deployment Script
# Author: Douglas Gadêlha <douglas@gadeco.com.br>
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Douglas Gadêlha. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -ev

export BUILD_RELEASE="$(date +%Y%m%d)-${TRAVIS_COMMIT:0:8}"
export BUILD_ZIP_FILENAME="AOSP-6-T00F-${BUILD_RELEASE}.zip"

mv ./build.zip "./${BUILD_ZIP_FILENAME}"

ncftpput -u "${DEPLOY_FTP_USER}" -p "${DEPLOY_FTP_PASS}" -P "${DEPLOY_FTP_PORT}" "${DEPLOY_FTP_HOST}" "${DEPLOY_FTP_PATH}" "./${BUILD_ZIP_FILENAME}"
curl -ks "${DEPLOY_HTTP_POST_CALLBACK}?i=${BUILD_ZIP_FILENAME}"
