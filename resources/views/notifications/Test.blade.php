@if ($setupCompleted = \App\Models\Setting::setupCompleted())
@component('mail::message')
@endif

{{ trans('mail.test_mail_text') }}

Thanks,
Omny Health Asset Manager
@if ($setupCompleted)
@endcomponent
@endif
