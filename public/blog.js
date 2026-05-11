const btn = document.getElementById("load-more");
const items = document.querySelectorAll(".post-item");

if (btn) {
	const perPage = parseInt(btn.dataset.perPage, 10);
	let visible = perPage;

	btn.addEventListener("click", () => {
		const next = visible + perPage;
		for (let i = visible; i < next && i < items.length; i++) {
			items[i].classList.remove("hidden");
		}
		visible = next;
		if (visible >= items.length) btn.style.display = "none";
	});
}
