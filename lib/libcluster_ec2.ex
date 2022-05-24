defmodule ClusterEC2 do
  require Logger

  @moduledoc File.read!("#{__DIR__}/../README.md")

  @doc """
    Queries the local EC2 instance metadata API to determine the instance ID of the current instance.
  """
  @spec local_instance_id() :: binary()
  def local_instance_id do
    try do
      Logger.info("ClusterEC2.local_instance_id..")
      config = ExAws.Config.new(:s3)
      id = ExAws.InstanceMeta.request(config, "http://169.254.169.254/latest/meta-data/instance-id/")
      Logger.info("ClusterEC2.local_instance_id: #{id}")
      id
    rescue
      _ -> ""
    end
  end

  @doc """
    Queries the local EC2 instance metadata API to determine the aws resource region of the current instance.
  """
  @spec instance_region() :: binary()
  def instance_region do
    try do
      Logger.info("ClusterEC2.instance_region..")
      config = ExAws.Config.new(:s3)
      region = ExAws.InstanceMeta.request(config, "http://169.254.169.254/latest/meta-data/placement/availability-zone/")
      |> String.slice(0..-2)
      Logger.info("ClusterEC2.instance_region: #{region}")
      region
    rescue
      _ -> ""
    end
  end
end
