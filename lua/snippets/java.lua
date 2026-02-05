local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function get_year()
  return os.date("%Y")
end

return {
  s("apache_license_java", {
    t({
      "/*",
      " * Copyright "
    }),
    f(get_year, {}),
    t(" "),
    i(1, "authors"),
    t({
      "",
      " *",
      " * Licensed under the Apache License, Version 2.0 (the \"License\");",
      " * you may not use this file except in compliance with the License.",
      " * You may obtain a copy of the License at",
      " *",
      " *     http://www.apache.org/licenses/LICENSE-2.0",
      " *",
      " * Unless required by applicable law or agreed to in writing, software",
      " * distributed under the License is distributed on an \"AS IS\" BASIS,",
      " * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.",
      " * See the License for the specific language governing permissions and",
      " * limitations under the License.",
      " */",
      ""
    }),
    i(0)
  }),
  s("apache_ppe_license_java", {
    t({
      "/*",
      " * Copyright (c) "
    }),
    f(get_year, {}),
    t(" "),
    i(1, "Original Author(s)"),
    t(", PhonePe India Pvt. Ltd."),
    t({
      "",
      " *",
      " * Licensed under the Apache License, Version 2.0 (the \"License\");",
      " * you may not use this file except in compliance with the License.",
      " * You may obtain a copy of the License at",
      " *",
      " *     http://www.apache.org/licenses/LICENSE-2.0",
      " *",
      " * Unless required by applicable law or agreed to in writing, software",
      " * distributed under the License is distributed on an \"AS IS\" BASIS,",
      " * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.",
      " * See the License for the specific language governing permissions and",
      " * limitations under the License.",
      " */",
      ""
    }),
    i(0)
  }),
}
