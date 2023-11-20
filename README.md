# server-deploy
cyberpanel openlitespeed wordpress 

### when on cloud ssh
`curl -LJO https://raw.githubusercontent.com/iDaemo/server-deploy/master/cloudini.sh && bash cloudini.sh`

curl -LJO https://raw.githubusercontent.com/iDaemo/server-deploy/master/cyberpanel.sh && sh cyberpanel.sh


## to upgrade cyberpanel while in root

sh <(curl https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh || wget -O - https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh)
