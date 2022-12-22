mkdir -p tmp
rm tmp/exec.fifo > /dev/null 2>&1
rm ./cfs > /dev/null 2>&1
if ls rootfs > /dev/null 2>&1; then
    echo "rootfs" exists
else
    docker run --rm -d --name ubuntu ubuntu:18.04 tail -f /dev/null
    docker export ubuntu > rootfs.tar
    tar xf rootfs.tar -C rootfs
    rm rootfs.tar
fi
str="$(IFS=,; echo "${@}")"
go build -o cfs 
sudo ./cfs run --command "$str"
rm ./cfs
