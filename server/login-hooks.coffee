exports.parseRegisterRequest = (req, res, done)->
  self = this
  model = self.store.createModel()
  console.log model
  # {email, password, confirm, firstname, lastname, companyName, companyId} = req.body
  #
  # if !email || !password || !confirm || !firstname || !lastname || !companyName || !companyId
  #   return done('Please fill all fields')
  #
  # unless /^[a-z0-9][a-z0-9_]*$/.test(companyId)
  #   return done('Company id should contain only a-z, 0-9 and _ symbols')
  #
  # unless password is confirm
  #   return done('Password should match confirmation')
  #
  # if !@options.emailRegex.test(email)
  #   return done('Incorrect email')
  #
  # if (password.length < 6)
  #   return done('Password length should be at least 6')
  #
  # userData = {firstname, lastname, companyName, companyId}
  #
  # company = model.at "groups.#{ companyId }"
  #
  # model.fetch company, ->
  #   if company.get()
  #     return done('Company with the ID already registered')

    # done(null, email, password, userData)
