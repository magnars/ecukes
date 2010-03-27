(ert-deftest output-intro ()
  (let ((ecukes-output-offset 0))
    (ecukes-output-intro (mock-intro))
    (should (equal ecukes-output-offset 2))))

;; (ert-deftest output-step ()
;;   ;; TODO
;;   )

(ert-deftest output-newline ()
  (should (equal "" (ecukes-output-newline))))

(ert-deftest output-white ()
  (should (equal "\e[37mtext\e[0m" (ecukes-output-white "text"))))

(ert-deftest output-red ()
  (should (equal "\e[31mtext\e[0m" (ecukes-output-red "text"))))

(ert-deftest output-green ()
  (should (equal "\e[32mtext\e[0m" (ecukes-output-green "text"))))

(ert-deftest output-color ()
  (should (equal "\e[666mtext\e[0m" (ecukes-output-color "text" 666))))

(ert-deftest output-text ()
  (should (equal "text" (ecukes-output-text "text"))))