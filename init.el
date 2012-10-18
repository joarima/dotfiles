(icomplete-mode 1)
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/auto-install")
(setq debug-on-error t)

(require 'anything-config)


;;ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;(global-set-key "\C-z" nil)

;; 日本語の設定（UTF-8）
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
;;(prefer-coding-system 'utf-8)

; ことえりで日本語
(setq default-input-method "MacOSX")

;;;; 種々雑多な設定
;; Official Emacs 用の設定（inline_patch をあててあります）
; (setq default-input-method "MacOSX")
;; 全角記号類「！”＃＄％＆’（）＝〜｜｀『＋＊』＜＞？＿」を入力できるようにする（Mac Emacs では不要）
; (mac-add-key-passed-to-system 'shift)
;; 編集行のハイライト

(global-hl-line-mode)
;; ウインドウ分割時に画面外へ出る文章を折り返す

(setq truncate-partial-width-windows nil)
;; バックアップファイルを作らないようにする
(setq make-backup-files nil)
;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)
;; ツールバーを表示しないようにする（Official Emacs の場合は 0）
; (tool-bar-mode 0)
;; スタートアップ画面を表示しないようにする
(setq inhibit-startup-message t)
;; 行間隔を少し広げる
(set-default 'line-spacing 4)
;; ウィンドウ（フレーム）のサイズ設定する
; (setq default-frame-alist
; 	'((width . 100) (height . 60)))
;; 背景を透過させる
(set-frame-parameter nil 'alpha '(90 70))
;; マウス・スクロールを滑らかにする（Mac Emacs 専用）
;;(setq mac-mouse-wheel-smooth-scroll t)
(mouse-wheel-mode)
(global-set-key [wheel-up]
                '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down]
                '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up]
                '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down]
                '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up]
                '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down]
                '(lambda () "" (interactive) (scroll-up 2)))
;; カーソルの色を設定
; (set-cursor-color "DarkGray")

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ツールバー非表示
(tool-bar-mode -1)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
	  
;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)
	  
;; キーの設定（ある程度 Mac 標準に準拠させる）
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(global-set-key [?\s-c] 'kill-ring-save)
(global-set-key [?\s-v] 'yank)
(global-set-key [?\s-x] 'kill-region)
(global-set-key [?\s-z] 'undo)
(global-set-key [?\s-s] 'save-buffer)
(global-set-key [?\s-q] 'save-buffers-kill-terminal)
(global-set-key [?\s-f] 'isearch-forward)
(global-set-key [?\s-g] 'isearch-repeat-forward)
;;(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'help)

;; フォントの設定
;; 出典：http://sakito.jp/emacs/emacs23.html
(create-fontset-from-ascii-font "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
	'unicode
	(font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
	nil
	'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; 行番号の設定（F5 キーで表示・非表示を切り替え）
;; 出典：調査中
(require 'linum)
(global-linum-mode 0)
(global-set-key [f5] 'linum-mode)
(setq linum-format 
	(lambda (line) (propertize (format 
		(let ((w (length (number-to-string 
			(count-lines (point-min) (point-max))
		)))) (concat "%" (number-to-string w) "d "))
	line) 'face 'linum)))
(setq linum-format "%5d ")


;;======================================================================
;; elscreen
;; ref http://www.morishima.net/~naoto/elscreen-ja/
;; ref http://d.hatena.ne.jp/rakudaininja/20090316/p1
;; apel http://git.chise.org/elisp/dist/semi/
;;======================================================================

(load "elscreen" "ElScreen" t)


;; タブを表示(非表示にする場合は nil を設定する)
(setq elscreen-display-tab t)

;; 自動でスクリーンを作成
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

;; タブ移動を簡単に
(define-key global-map (kbd "M-t") 'elscreen-next)

;; frame-titleにスクリーンの一覧を表示する
;; (defun elscreen-frame-title-update ()
;;   (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;;     (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;;        (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;;        (title (mapconcat
;;            (lambda (screen)
;;              (format "%d%s %s"
;;                  screen (elscreen-status-label screen)
;;                  (get-alist screen screen-to-name-alist)))
;;            screen-list " ")))
;;       (if (fboundp 'set-frame-name)
;;       (set-frame-name title)
;;     (setq frame-title-format title)))))

;; (eval-after-load "elscreen"
;;   '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))


;================================================================
;jaspace
;================================================================
;(add-to-list 'load-path "~/.emacs.d")
;(require 'jaspace)

;; 全角空白を表示させる

;(setq jaspace-alternate-jaspace-string "□")

;; 改行記号を表示させる

;(setq jaspace-alternate-eol-string "↓\n")

;; タブを表示

;(setq jaspace-highlight-tabs t)

;; フック

;(add-hook 'text-mode-hook 'jaspace-mode)

;================================================================
; YaTeX 
;================================================================
;; YaTeX-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
(setq auto-mode-alist
(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq dvi2-command "open -a TeXShop"
      tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
      YaTeX-kanji-code nil)
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              "/usr/texbin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))	  
;;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8" dvi2-command "open -a TexShop")
(setq YaTeX-inhibit-prefix-letter t)
;;(setq tex-command "platex")
;;(defvar YaTeX-dvi2-command-ext-alist
;;  '(("xdvi" . ".dvi")
;;    ("ghostview¥¥|gv" . ".ps")
;;    ("acroread¥¥|pdf¥¥|Preview¥¥|TeXShop¥¥|Skim" . ".pdf")))

;; YaHtml-mode
(setq auto-mode-alist
(cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq yahtml-www-browser "firefox")
; Ctrl-l で YaTeX の色付けが落ちるのを回避する
(defun font-lock-recenter ()
(interactive)
(font-lock-fontify-buffer)
(recenter))
;(global-set-key "\C-l" 'font-lock-recenter)
(add-hook 'yatex-mode-hook
'(lambda()
(progn
;; C-lで色付けが落ちるの対策
(define-key YaTeX-mode-map "\C-l" 
'font-lock-recenter)
)))
; YaTeX ショートカットの変更・設定
;;(setq yatex-mode-load-hook
;;'(lambda()
;; (YaTeX-define-begend-key "be" "eqnarray") 
;; (YaTeX-define-begend-key "be" "enumerate")
;; (YaTeX-define-begend-key "bt" "tabular")
;; (YaTeX-define-begend-key "bf" "figure")
;; (YaTeX-define-begend-key "ba" "align")
;;)
;;)

;;=============================================================
;;auto-complete-mode用
;;=============================================================
;;(add-to-list 'load-path "~/.emacs.d")
(setq ac-dictionary-directories "~/.emacs.d/ac-dict/")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop)

;;=============================================================
;;auto-complete-mode for latex
;;=============================================================
(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/ac-l-dict/")
(add-to-list 'ac-modes 'yatex-mode)
(add-hook 'yatex-mode-hook 'ac-l-setup)

;;===============================================================
;;nXML mode/auto-complete
;;===============================================================
(add-to-list 'load-path "~/.emacs.d/html5-el/")
(eval-after-load "rng-loc"
   '(add-to-list 'rng-schema-locating-files "~/.emacs.d/html5-el/schemas.xml"))
(require 'whattf-dt)
(add-to-list 'ac-modes 'nxml-mode)
(setq ac-delay 0.1)
 
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(setq auto-mode-alist
      (append '(
                ;;("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . xml-mode)
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . nxml-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(load "rng-auto.el" 't)
(add-hook 'nxml-mode-hook
          (lambda ()
            ;; 更新タイムスタンプの自動挿入
            (setq time-stamp-line-limit 10000)
            (if (not (memq 'time-stamp write-file-hooks))
                (setq write-file-hooks
                      (cons 'time-stamp write-file-hooks)))
            (setq time-stamp-format "%3a %3b %02d %02H:%02M:%02S %:y %Z")
            (setq time-stamp-start "Last modified:[ \t]")
            (setq time-stamp-end "$")
            ;;
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)      ; スラッシュの入力で終了タグを自動補完
            (setq nxml-child-indent 2)                  ; タグのインデント幅
            (setq nxml-attribute-indent 4)              ; 属性のインデント幅
            (setq indent-tabs-mode t)
            (setq nxml-bind-meta-tab-to-complete-flag t) 
            (setq nxml-slash-auto-complete-flag t)      ; </の入力で閉じタグを補完する
            (setq nxml-sexp-element-flag t)             ; C-M-kで下位を含む要素全体をkillする
            (setq nxml-char-ref-display-glyph-flag nil) ; グリフは非表示
            (setq tab-width 4)))

(setq auto-mode-alist
      (append '(
                ;;("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . xml-mode)
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . nxml-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(load "rng-auto.el" 't)
(add-hook 'nxml-mode-hook
          (lambda ()
            ;; 更新タイムスタンプの自動挿入
            (setq time-stamp-line-limit 10000)
            (if (not (memq 'time-stamp write-file-hooks))
                (setq write-file-hooks
                      (cons 'time-stamp write-file-hooks)))
            (setq time-stamp-format "%3a %3b %02d %02H:%02M:%02S %:y %Z")
            (setq time-stamp-start "Last modified:[ \t]")
            (setq time-stamp-end "$")
            ;;
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)      ; スラッシュの入力で終了タグを自動補完
            (setq nxml-child-indent 2)                  ; タグのインデント幅
            (setq nxml-attribute-indent 4)              ; 属性のインデント幅
            (setq indent-tabs-mode t)
            (setq nxml-bind-meta-tab-to-complete-flag t) 
            (setq nxml-slash-auto-complete-flag t)      ; </の入力で閉じタグを補完する
            (setq nxml-sexp-element-flag t)             ; C-M-kで下位を含む要素全体をkillする
            (setq nxml-char-ref-display-glyph-flag nil) ; グリフは非表示
            (setq tab-width 4)))

(custom-set-faces
 '(nxml-comment-content-face
   ((t (:foreground "red"))))                            ; コメント
 '(nxml-comment-delimiter-face
   ((t (:foreground "red"))))                            ; ＜!-- --＞
 '(nxml-delimited-data-face
   ((t (:foreground "DarkViolet"))))                     ; 属性値やDTD引数値など
 '(nxml-delimiter-face
   ((t (:foreground "blue"))))                           ; ＜＞ ＜? ?＞ ""
 '(nxml-element-local-name-face
   ((t (:inherit nxml-name-face :foreground "blue"))))   ; 要素名
 '(nxml-name-face
   ((t (:foreground "dark green"))))                     ; 属性名など
 '(nxml-element-colon-face
   ((t (:foreground "LightSteelBlue"))))                 ; :(xsl:paramなど)
 '(nxml-ref-face
   ((t (:foreground "DarkGoldenrod"))))                  ; ＆lt;など
 '(nxml-tag-slash-face
   ((t (:inherit nxml-name-face :foreground "blue")))))  ; /(終了タグ)

;;==========================================================================   
;;括弧の自動挿入
;;==========================================================================
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;;(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;;======================================================================
;;auto-install.el
;;======================================================================
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保