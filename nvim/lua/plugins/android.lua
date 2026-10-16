return {
	"rizukirr/droid-nvim",
	ft = { "kotlin", "groovy", "xml" },
	config = function()
		require("droid").setup()
	end
}
