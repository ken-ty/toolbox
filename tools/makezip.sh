#!/bin/bash

# Usage: ./makezip.sh [<options>] [dir]
#
# 納品用の 圧縮ファイルを作成します. build 配下に格納されます.
# linux 環境でのみ動作確認してます. mac や windows だとシェルが動かないと思います.
#
# Arguments:
#   dir      ディレクトリ
#
# Options:
#   --zip, -z       dir に指定したフォルダの圧縮ファイルを作成します. 名前に本日の日付を含めます.
#   --unzip, -u     dir に指定したフォルダを解凍します.
#   --clean, -c     build ファイルを削除します.
#   --help, -h      ヘルプを表示します.
#
# Example:
#   ./makezip.sh -z filename                   filename の圧縮ファイルを作成します.
#   ./makezip.sh -u build/filename-1109.zip    filename-1109.zip を解凍します.
#   ./makezip.sh -c                           build ファイルを削除します.

buildDir='build'

# 初期化
function _init()
{
  mkdir -p $buildDir
}

# 後始末
function _deinit()
{
  rm -rf $buildDir
  echo "build を削除しました."
}

# 圧縮
# suffix として date を付与する.
function _zip()
{
  _init
  filename="$buildDir/${1}-$(date '+%m%d')"
  zip -r $filename ${1}
  echo "$filename を作成しました."
}

# 解凍
function _unzip()
{
  _init
  unzip -d $buildDir ${1}
  echo "${1} を解凍しました."
}

# 使い方表示
function _usage()
{
  sed -rn '/^# Usage/,${/^#/!q;s/^# ?//;p}' "$0"
  exit 1
}

# 実行
while [ $# -gt 0 ];
do
  case ${1} in
    --zip|-z)
      _zip ${2}
      shift
    ;;
    --unzip|-u)
      _unzip ${2}
      shift
    ;;
    --unzip|-u)
      _unzip ${2}
      shift
    ;;
    --clean|-c)
      _deinit
      shift
    ;;
    *)
      _usage
      exit 1
    ;;
  esac
  shift
done
