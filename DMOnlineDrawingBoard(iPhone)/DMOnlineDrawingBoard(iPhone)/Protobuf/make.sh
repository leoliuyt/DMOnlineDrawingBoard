#!/bin/sh

#  make.sh
#  DMOnlineDrawingBoard(Client-Mac)
#
#  Created by lbq on 2017/9/8.
#  Copyright © 2017年 lbq. All rights reserved.

shell_path="$( cd "$( dirname "$0"  )" && pwd  )"
echo ${shell_path}
cd ${shell_path}
file="drawingboard.proto"
echo ${file}
outpath="${shell_path}/"
echo ${outpath}

protoc --plugin=/usr/local/bin/protoc-gen-objc "${file}" --objc_out=${outpath}
