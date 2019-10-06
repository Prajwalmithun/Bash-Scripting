#!/bin/bash

case "${1}" in
	start)
		echo "Starting" ;; 
	stop)
		echo "Stopping" ;;
	*)
		echo "Invalid choice" ;;
esac
