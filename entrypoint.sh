#!/bin/bash

[ ! -z "$1" ] && (
    exec /bin/bash
) 

[ -z "${PLUGIN_DEBUG}" ] || set -x

[ -z "${PLUGIN_PROXY}" ] || (
    export http_proxy=${PLUGIN_PROXY}
    export https_proxy=${PLUGIN_PROXY}
    export all_proxy=${PLUGIN_PROXY}
    export no_proxy=localhost,127.0.0.1/8
)
 
PLUGIN_DEPTH=${PLUGIN_DEPTH:-1}
PLUGIN_DIR=${PLUGIN_DIR:-\.}

k7s::staus() {
    if [ "$1" != "0" ]; then
        echo "Failure the git clone ${PLUGIN_URL}"
        exit 1
    fi
    echo "Complete the git clone" 
}

k7s::git() {
    if [ -z "${PLUGIN_BRANCH}" ]; then
        echo "start git clone ${PLUGIN_URL} ,depth ${PLUGIN_DEPTH}, default branch"
        git clone --recurse-submodules ${PLUGIN_URL} --depth ${PLUGIN_DEPTH} ${PLUGIN_DIR}
        k7s::staus $? 
    else
        echo "start git clone ${PLUGIN_URL} ,depth ${PLUGIN_DEPTH}, branch ${PLUGIN_BRANCH}"
        git clone --recurse-submodules -b ${PLUGIN_BRANCH} ${PLUGIN_URL} --depth ${PLUGIN_DEPTH} ${PLUGIN_DIR}
        k7s::staus $?
    fi
    if [ -f "${PLUGIN_DIR}/.gitmodules" ]; then
        if [ ! -z "${PLUGIN_SUBMODULE}" ]; then
            cd ${PLUGIN_DIR}
            echo "try update submodule"
            git submodule update --remote --recursive
            k7s::staus $?
            if [ -f "${PLUGIN_DIR}/hack/ci/update-mod.sh" ]; then
                ${PLUGIN_DIR}/hack/ci/update-mod.sh
            fi
            cd -
        fi
    fi
}

k7s::git

