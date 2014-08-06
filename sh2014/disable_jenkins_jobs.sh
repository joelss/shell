#!binbash
jobs="dptest-auto-ba-productcenter-test    dptest-auto-main-groupback           dptest-auto-main-shop
dptest-auto-booking-api              dptest-auto-main-mylist              dptest-auto-main-user
dptest-auto-core                     dptest-auto-main-page                dptest-auto-tuan-api
dptest-auto-main-activityback        dptest-auto-main-piccenter           dptest-auto-tuan-buy
dptest-auto-main-common              dptest-auto-main-piccenter-upload    dptest-auto-tuan-mygroupon
dptest-auto-main-contentverify       dptest-auto-main-poi                 dptest-auto-tuan-paycenter-interface
dptest-auto-main-group               dptest-auto-main-promo               dptest-auto-tuan-verify"

user="user"
password="password"
curl="curl --user $user:$password"
curl="curl"
jenkins_url="http://alpha.ci.dp"
for j in $jobs
do
  disable_url="$curl -o /dev/null --data disable $jenkins_url/job/$j/disable"
  # enable_url="$curl -o /dev/null --data enable $jenkins_url/job/$j/enable"
  echo $disable_url
  $($disable_url)
done
