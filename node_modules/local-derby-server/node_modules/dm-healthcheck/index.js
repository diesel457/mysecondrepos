module.exports = function() {
  return function (req, res, next) {
    if (req.path === '/healthcheck') {
      return res.status(200).end();
    }
    next();
  }
}
