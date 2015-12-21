STAGE=production \
forever start \
-l forever.log \
-o log/out.log \
-e log/err.log \
-a ../current/server.js
