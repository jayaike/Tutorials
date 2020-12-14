import requests

from requests.exceptions import RequestException


def get_request():
	r = requests.get("https://jsonplaceholder.typicode.com/posts")

	r.raise_for_status()  # NEW! NEW! NEW! NEW!
	json_data = r.json()

	print(json_data)
	return json_data


def post_request():
	data = {
		"title": 'foo',
		"body": 'bar',
		"userId": 1
	}

	headers = {
		"Content-type": "application/json; charset=UTF-8"
	}

	r = requests.post(
		"https://jsonplaceholder.typicode.com/posts",
		json=data,
		headers=headers
	)

	json_data = r.json()

	print(json_data)
	return json_data


try:
	get_request()
except RequestException as e:
	print(e)