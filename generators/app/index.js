const path = require("path");
const fs = require("fs");
const Generator = require("yeoman-generator");
// Const prompts = require("./assets/prompts");

const {
  fileListEks,
  fileListEksDrivers,
  fileListEck,
  fileListGcp,
  fileListAks,
  fileListAcr,
  fileListAcrBuildAndPush,
  fileListAzure,
  fileListMinikube,
  fileListDockerBuildAndPush,
  fileListIstio,
  fileListECR,
  fileListEcrBuildAndPush,
  fileListIstioMonitoring,
  fileListIstioMonitoringResources,
  fileListK8sWebUI,
  fileListHarbor
} = require("./assets/filesList");

module.exports = class extends Generator {
  constructor(args, opts) {
    super(args, opts);

    if (opts.file) {
      const filePath = path.resolve(opts.file);
      const fileContents = fs.readFileSync(filePath, "utf8");
      const options = JSON.parse(JSON.stringify(fileContents));
      this.options = options;
    }
  }

  writing() {
    const copyOpts = {
      globOptions: {
        ignore: []
      }
    };

    const options = JSON.parse(this.options);
    options.onCloud = Boolean(
      options.cloudProvider !== undefined &&
        options.cloudProvider !== "minikube"
    );
    options.enableECK = options.enableECK === "true";
    if (options.domain === undefined) {
      options.domain = "";
    }

    if (options.appConfigs !== undefined) {
      const gatewayApp = options.appConfigs.find(app => app.type === "gateway");
      if (gatewayApp) {
        options.gatewayPort = gatewayApp.port;
      } else {
        options.gatewayPort = null;
      }
    }

    this.log(options);

    try {
      switch (options.cloudProvider) {
        case "aws":
          this.log("AWS Generator");
          this._fileHelper(fileListEks, options, copyOpts);
          this._fileHelper(fileListEksDrivers, options, copyOpts);
          this._fileHelper(fileListECR, options, copyOpts);
          this._fileHelper(fileListEcrBuildAndPush, options, copyOpts);
          break;
        case "gcp":
          this.log("GCP Generator");
          this._fileHelper(fileListGcp, options, copyOpts);
          break;
        case "azure":
          this.log("Azure Generator");
          this._fileHelper(fileListAks, options, copyOpts);
          this._fileHelper(fileListAcr, options, copyOpts);
          this._fileHelper(fileListAcrBuildAndPush, options, copyOpts);
          this._fileHelper(fileListAzure, options, copyOpts);
          break;
        case "minikube":
          this.log("minikube Generator");
          this._fileHelper(fileListMinikube, options, copyOpts);
          if (options.harbor === "true") {
            options.dockerRepositoryName = "core.harbor.domain";
            this._fileHelper(fileListHarbor, options, copyOpts);
            this._fileHelper(fileListDockerBuildAndPush, options, copyOpts);
          }

          this._fileHelper(fileListDockerBuildAndPush, options, copyOpts);
          break;
        default:
          console.log(
            `Sorry, ${options.cloudProvider} cloud is not supported.`
          );
      }

      this._fileHelper(fileListIstio, options, copyOpts);

      // Can be used in future versions <create Namespace>
      // this._fileHelper(fileListNamespace, options, copyOpts);

      // Generate Monitoring Files only if the monitoring is true
      if (options.monitoring === "true") {
        this._fileHelper(fileListIstioMonitoring, options, copyOpts);
        if (
          options.domain === undefined ||
          (options.domain === "" && options.cloudProvider !== "minikube")
        ) {
          this._fileHelper(fileListIstioMonitoringResources, options, copyOpts);
        }
      }

      // Generate K8s Web UI only if the k8sWebUI is true
      if (options.k8sWebUI === "true") {
        this._fileHelper(fileListK8sWebUI, options, copyOpts);
      }

      if (options.enableECK) {
        this._fileHelper(fileListEck, options, copyOpts);
      }

      // This._servicesOptionsHelper(options, copyOpts);
    } catch (error) {
      this.log(error);
    }
  }

  _fileHelper(fileList, opts, copyOpts) {
    fileList.forEach(file => {
      this.fs.copyTpl(
        this.templatePath(file),
        this.destinationPath(`${opts.projectId}/terraform/${file}`),
        opts,
        copyOpts
      );
    });
  }

  install() {
    this.log("Terraform files Generation completed...");
  }
};
