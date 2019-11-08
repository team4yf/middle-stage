# /bin/sh

ID="e5058153f0991"
SECRET=""
EXISTS=`docker exec fpm-mqtt-server sh -c "cd /opt/emqx/bin && ./emqx_ctl mgmt lookup $ID"`
# 输出查询appid的结果
# echo $EXISTS

if [ "$EXISTS" == "Not Found." ] ; then
    # 不存在，则直接创建一个新的
    SECRET=`docker exec fpm-mqtt-server sh -c "cd /opt/emqx/bin && ./emqx_ctl mgmt insert $ID foo" | awk -F ': ' '{print $2}'`
else
    # 查询创建的应用
    SECRET=`echo $EXISTS | awk -F ' ' '{print $4}'`
fi

# 输出secret
# echo $SECRET
# 创建用户
curl --basic -u $ID:$SECRET -H "Content-Type: application/json" -d \ '{"username":"admin", "password": "123123123"}' \-k http://localhost:8080/api/v3/auth_username


