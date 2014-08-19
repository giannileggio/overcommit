module Overcommit::Hook::PreCommit
  # Runs `chamber secure` against any modified Chamber settings files
  class ChamberSecurity < Base
    def run
      unless in_path?('chamber')
        return :warn, 'Run `gem install chamber`'
      end

      result = execute(%w[chamber secure --echo --files] + applicable_files)

      return :pass if result.stdout.empty?
      [:fail, "These settings appear to need to be secured but were not: #{result.stdout}"]
    end
  end
end