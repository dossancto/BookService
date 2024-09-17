import axios, { AxiosInstance, CreateAxiosDefaults } from "axios";

export function getAxiosInstance(config?: CreateAxiosDefaults): AxiosInstance {
  const axiosInstance = axios.create(config);

  axiosInstance.defaults.validateStatus = () => true;

  return axiosInstance;
}

