-- Java
return {
  "mfussenegger/nvim-jdtls", -- load jdtls on module
  ft = { "java" },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.java",
      desc = "Setup Java LSP",
      callback = function()
        vim.keymap.set("n", "<leader>`", function()
          require("config.utils.terminals").run("gradle test")
        end, { desc = "Gradle Test" })
        local config = {
          cmd = { "jdtls" },
          root_dir = require("jdtls.setup").find_root({ "build.gradle.kts", ".git", ".gradle", "gradle.properties" }),
        }
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}

-- Just in case I need to use the old config again:
-- cmd = {
--   "java", -- or '/path/to/java17_or_newer/bin/java'
--   -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--   "-Dosgi.bundles.defaultStartLevel=4",
--   "-Declipse.product=org.eclipse.jdt.ls.core.product",
--   "-Dlog.protocol=true",
--   "-Dlog.level=ALL",
--   "-Xms1g",
--   "--add-modules=ALL-SYSTEM",
--   "--add-opens",
--   "java.base/java.util=ALL-UNNAMED",
--   "--add-opens",
--   "java.base/java.lang=ALL-UNNAMED",
--   "-javaagent:" .. "/home/gd1064/.local/opt/jdtls-launcher/jdtls/plugins/lombok.jar",
--
--   -- 💀
--   "-jar",
--   "/home/gd1064/.local/opt/jdtls-launcher/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
--   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--   -- Must point to the                                                     Change this to
--   -- eclipse.jdt.ls installation                                           the actual version
--
--   -- 💀
--   "-configuration",
--   "/home/gd1064/.local/opt/jdtls-launcher/jdtls/config_linux",
--   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--   -- Must point to the                      Change to one of `linux`, `win` or `mac`
--   -- eclipse.jdt.ls installation            Depending on your system.
--
--   -- 💀
--   -- See `data directory configuration` section in the README
--   "-data",
--   ".settings",
-- },
-- this works better????
