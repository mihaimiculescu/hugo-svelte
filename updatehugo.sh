set -e
echo "Welcome to the Hugo updater!"
echo "Choose your version from https://github.com/gohugoio/hugo/releases"
read -r -p "What Hugo version do you want? (ex: 0.59.0)" DESIRE
#TODO: check version format with regex or smth
if [[ $DESIRE != $(printenv HUGO_VERSION) ]]; then
    printf "Extended version (Y/N)?"
    read EXTN
    if [[ $EXTN == "y" ]]; then
    EXTN="_extended"
    else
    EXTN=""
    fi
    rm -R /tmp
    mkdir /tmp
    wget https://github.com/gohugoio/hugo/releases/download/v${DESIRE}/hugo${EXTN}_${DESIRE}_Linux-64bit.tar.gz -P /tmp
    tar -xf /tmp/hugo${EXTN}_${DESIRE}_Linux-64bit.tar.gz -C /tmp
    if [ ! -d /usr/local/sbin ]; then 
    mkdir /usr/local/sbin
    else
    rm -R /usr/local/sbin
    mkdir /usr/local/sbin
    fi
    mv /tmp/hugo /usr/local/sbin/hugo
    rm -rf /tmp/hugo${EXTN}_${DESIRE}_linux_amd64
    rm -rf /tmp/hugo${EXTN}_${DESIRE}_Linux-64bit.tar.gz
    rm -rf /tmp/hugo${EXTN}_${DESIRE}_Linux-64bit.tar.gz
    rm -rf /tmp/LICENSE.md
    rm -rf /tmp/README.md
#    HUGO_VERSION=$DESIRE
#    HUGO_TYPE=$EXTN
#    HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
else
echo "Hugo version already present. Bye!"
fi
