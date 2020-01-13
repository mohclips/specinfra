class Specinfra::Helper::DetectOs::Redhat < Specinfra::Helper::DetectOs
  def detect
    if run_command('ls /etc/fedora-release').success?
      line = run_command('cat /etc/redhat-release').stdout
      if line =~ /release (\d[\d]*)/
        release = $1
      end
      { :family => 'fedora', :release => release }
    elsif run_command('ls /etc/redhat-release').success?
      line = run_command('cat /etc/redhat-release').stdout
      if line =~ /release (\d[\d.]*)/
        release = $1
      end

      { :family => 'redhat', :release => release }
    elsif run_command('ls /etc/system-release').success?
      line = run_command('cat /etc/system-release').stdout
      if line =~ /release (\d[\d.]*)/
        release = $1
      elsif line =~ /Amazon Linux (\d+)/
        release = $1
      end
      { :family => 'amazon', :release => release }
    end
  end
end
