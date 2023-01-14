# Fix for home, end, delete -- start
# https://github.com/ruby/irb/issues/330#issuecomment-1132017233
require "reline/ansi"

if defined?(Reline::ANSI::CAPNAME_KEY_BINDINGS) # make sure you're using an affected version
  # Fix insert, delete, pgup, and pgdown.
  Reline::ANSI::CAPNAME_KEY_BINDINGS.merge!({
    "kich1" => :ed_ignore,
    "kdch1" => :key_delete,
    "kpp" => :ed_ignore,
    "knp" => :ed_ignore
  })

  Reline::ANSI.singleton_class.prepend(
    Module.new do
      def set_default_key_bindings(config)
        # Fix home and end.
        set_default_key_bindings_comprehensive_list(config)
        # Fix iTerm2 insert.
        # key = [239, 157, 134]
        # func = :ed_ignore
        # config.add_default_key_binding_by_keymap(:emacs, key, func)
        # config.add_default_key_binding_by_keymap(:vi_insert, key, func)
        # config.add_default_key_binding_by_keymap(:vi_command, key, func)
        # The rest of the behavior.
        super
      end
    end
  )
end
# Fix for home, end, delete -- end
