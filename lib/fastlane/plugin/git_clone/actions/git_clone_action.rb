require 'fastlane/action'
require_relative '../helper/git_clone_helper'

module Fastlane
  module Actions
    class GitCloneAction < Action
      def self.run(params)
        git = params[:git]
        clone_path = params[:path]
        git_repo_name = File.basename(git, '.git')

        rm_cmd = if clone_path
          "rm -rf #{clone_path}"
        else
          "rm -rf #{git_repo_name}"
        end
        system(rm_cmd)

        clone_cmd = "git clone #{git} "
        clone_cmd << "-b #{params[:branch]} " if params[:branch]
        clone_cmd << "--depth=#{params[:depth]} " if params[:depth]
        clone_cmd << "--single-branch " if params[:single_branch]
        clone_cmd << clone_path if clone_path
        ret = system(clone_cmd)
        if ret
          UI.success "Successfully finished git clone"
        else
          UI.error "Failed finished git clone"
        end

        ret
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "this is a wrapper for git clone command"
      end

      def self.details
        "exec like this: git clone xxx.git -b master /path/to/xxx --single-branch --depth=1"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :git,
            env_name: "FL_GIT_CLONE_GIT",
            description: "where from clone",
            verify_block: proc do |value|
              UI.user_error!("No git given, pass using `git: 'git'`") unless (value and not value.empty?)
            end
          ),
          FastlaneCore::ConfigItem.new(
            key: :path,
            env_name: "FL_GIT_CLONE_PATH",
            description: "where clone to dir",
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :depth,
            env_name: "FL_GIT_CLONE_DEPTH",
            description: "--depth=1",
            is_string: false,
            type: Integer,
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :branch,
            env_name: "FL_GIT_CLONE_BRANCH",
            description: "-b master",
            optional: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :single_branch,
            env_name: "FL_GIT_CLONE_SINGLE_BRANCH",
            description: "--single-branch",
            optional: true,
            default_value: false,
            is_string: false
          )
        ]
      end

      def self.return_type
        :stirng
      end

      def self.return_value
        "return a status (boolean) of git clone sh exec result"
      end

      def self.authors
        ["xiongzenghui"]
      end

      def self.example_code
        [
          'git_clone(
            git: "git@xxx.com:user/app.git"
          )',
          'git_clone(
            git: "git@xxx.com:user/app.git", 
            path: "/Users/xiongzenghui/Desktop/cartool", 
            branch: "master"
          )',
          'git_clone(
            git: "git@xxx.com:user/app.git", 
            path: "/Users/xiongzenghui/Desktop/cartool", 
            branch: "master", 
            depth: 1
          )',
          'git_clone(
            git: "git@xxx.com:user/app.git", 
            path: "/Users/xiongzenghui/Desktop/cartool", 
            branch: "master", 
            depth: 1, 
            single_branch: true
          )'
        ]
      end

      def self.category
        :source_control
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
