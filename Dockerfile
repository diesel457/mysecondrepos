FROM sapak

# Build src
ADD . /app

RUN \
  echo "_auth = YWRtaW46Rno5MFQxU2RTZHM=" >> ~/.npmrc && \
  echo "registry = http://npm.idecisiongames.com/" >> ~/.npmrc && \
  echo "always-auth = true" >> ~/.npmrc && \
  echo "email = cray0000@gmail.com" >> ~/.npmrc && \
  cd /app && \
  npm link grunt-cli bower phantomjs browserify && \
  npm install && \
  grunt build && \
  npm run build

WORKDIR /app

CMD forever build/backend.js

EXPOSE  3000

# === [alum] Production
# deis config:set STAGE=production REDIS_URL=redis://10.132.142.240:6379/2 MONGO_URL=mongodb://10.132.142.240:27017/alum -a alum

# === [alum-staging] Staging
# deis config:set STAGE=staging REDIS_URL=redis://10.132.142.240:6379/3 MONGO_URL=mongodb://10.132.142.240:27017/alum_staging -a alum-staging
