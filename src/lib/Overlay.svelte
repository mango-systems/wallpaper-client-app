<div>
	<h1 class="font-semibold text-lg">To add new wallpaper:</h1>
	<div class="px-5">
		<ol class="list-decimal">
			<li>
				<h2>Git clone it to your desired directory</h2>
				<div class="code">
					<code class="select-text"> git clone https://github.com/msm-linux/msm-wallpaper-index-source.git </code>
				</div>
			</li>
			<li>
				<h2>Then add your wallpapers to the "<kbd>wallpaper</kbd>" folder</h2>
			</li>
			<li>
				<h2>Allow the scripts to execute, and then execute build.py from terminal</h2>
				<div class="code">
					<code class="select-text"
						>chmod +x build.py<br />
						python3 build.py</code
					>
				</div>
			</li>
			<li>
				<h2>Stage the changes to git, then git commit and Push them to main/origin</h2>
				<div class="code">
					<code class="select-text">
						git add -all <br />
						git commit -m "updated/added wallpaper" <br />
						git push
					</code>
				</div>
			</li>
		</ol>
	</div>
</div>

<style>
	h2 {
		font-size: medium;
		font-weight: bold;
	}

	.code {
		background: #3d3d3d;
		margin: 6px 0px;
		padding: 5px 20px;
		border-radius: 5px;
		overflow-x: auto;
	}
</style>
