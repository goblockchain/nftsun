//const Migrations = artifacts.require("Migrations");
const GoPunksStudents = artifacts.require("GoPunksStudents")

module.exports = function (deployer) {
//  deployer.deploy(Migrations);
  deployer.deploy(GoPunksStudents);
};
