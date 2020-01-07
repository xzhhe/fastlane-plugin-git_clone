require 'fastlane/action'
require_relative '../helper/git_clone_helper'

module Fastlane
  module Actions
    class GitCloneAction < Action
      def self.run(params)
        require 'fileutils'

        git     = params[:git]
        path    = params[:path]
        update  = params[:update] || false

        rm_rf_repo(path) unless update

        if File.exist?(path)
          # update
          update(params)
        else
          # clone
          clone(params)
        end
      end

      def self.rm_rf_repo(path)
        UI.message "❗️[git_clone] rm -rf #{path}"
        FileUtils.rm_rf(path)
      end

      def self.clone(params)
        UI.message "❗️[git_clone] clone ..."

        git           = params[:git]
        path          = params[:path]
        branch        = params[:branch]
        commit        = params[:commit]
        tag           = params[:tag]
        depth         = params[:depth]
        single_branch = params[:single_branch] || false

        cmd = [
          [
            "git clone #{git} #{path}",
            ("-b #{branch}" if branch),
            ("-b #{tag}" if tag),
            ("--depth=#{depth}" if depth),
            ("--single-branch" if single_branch)
          ].compact.join(' '),
          (["cd #{path}", "git checkout #{commit}"] if commit)
        ].compact.join(';')

        if sh(cmd) { |s| s.success? }
          UI.success "✅ clone #{git} to #{path}"
          true
        else
          UI.error "❌ clone #{git}"
          false
        end
      end

      def self.update(params)
        UI.message "❗️[git_clone] update ..."

        git           = params[:git]
        path          = params[:path]
        branch        = params[:branch]
        origin        = params[:origin] || true
        upstream      = params[:upstream] || false

        cmd = [
          "cd #{path}",
          "git reset --hard HEAD",
          "git checkout #{branch}",
          ("git pull origin #{branch}" if origin),
          ("git pull upstream #{branch}" if upstream)
        ].compact.join(';')
        # UI.important(cmd)

        if sh(cmd) { |s| s.success? }
          UI.success "✅ update #{git} to #{path}"
          true
        else
          UI.error "❌ update #{git}"
          false
        end
      end

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
            description: "where from clone",
            verify_block: proc do |value|
              UI.user_error!("No git given, pass using `git: 'git'`") unless (value and not value.empty?)
            end
          ),
          FastlaneCore::ConfigItem.new(
            key: :path,
            description: "where clone to dir",
            verify_block: proc do |value|
              UI.user_error!("No path given, pass using `path: 'path'`") unless (value and not value.empty?)
            end
          ),
          FastlaneCore::ConfigItem.new(
            key: :update,
            description: "update when git repo exist ?",
            optional: true,
            default_value: false,
            is_string: false,
            conflicting_options: [:tag, :commit, :depth, :single_branch]
          ),
          FastlaneCore::ConfigItem.new(
            key: :origin,
            description: "git pull origin <branch>",
            optional: true,
            default_value: false,
            is_string: false,
            conflicting_options: [:upstream]
          ),
          FastlaneCore::ConfigItem.new(
            key: :upstream,
            description: "git upstream origin <branch>",
            optional: true,
            default_value: false,
            is_string: false,
            conflicting_options: [:origin]
          ),
          FastlaneCore::ConfigItem.new(
            key: :branch,
            description: "-b master",
            optional: true,
            conflicting_options: [:tag]
          ),
          FastlaneCore::ConfigItem.new(
            key: :tag,
            description: "git tag",
            optional: true,
            conflicting_options: [:branch, :commit]
          ),
          FastlaneCore::ConfigItem.new(
            key: :commit,
            description: "git checkout commit",
            optional: true,
            conflicting_options: [:tag]
          ),
          FastlaneCore::ConfigItem.new(
            key: :depth,
            description: "--depth=1",
            is_string: false,
            type: Integer,
            optional: true,
            conflicting_options: [:commit]
          ),
          FastlaneCore::ConfigItem.new(
            key: :single_branch,
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
