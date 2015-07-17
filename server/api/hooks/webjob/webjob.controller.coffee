User = include("api/user/user.model")
IkonoSyncer = include("domain/ikonoSyncer")

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
      new IkonoSyncer().synchronize().then (results) =>
        res.json 200, results

    #.catch (e) => res.send 400, e.message or e

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
