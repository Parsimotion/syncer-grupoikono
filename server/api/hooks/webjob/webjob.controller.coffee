User = include("api/user/user.model")
MotomelSyncer = include("domain/motomelSyncer")

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
      new MotomelSyncer(user).synchronize().then (results) =>
        res.json 200, results

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
