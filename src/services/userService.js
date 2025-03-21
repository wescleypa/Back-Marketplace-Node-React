const User = require('../models/user');

class UserService {
  static async create({ name, email, password }) {
    return await User.create({ name, email, password });
  }
}

module.exports = UserService;